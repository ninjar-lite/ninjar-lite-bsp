#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

#define IH_NMLEN		32	/* Image Name Length		*/
struct legacy_img_hdr {
	uint32_t	ih_magic;	/* Image Header Magic Number	*/
	uint32_t	ih_hcrc;	/* Image Header CRC Checksum	*/
	uint32_t	ih_time;	/* Image Creation Timestamp	*/
	uint32_t	ih_size;	/* Image Data Size		*/
	uint32_t	ih_load;	/* Data	 Load  Address		*/
	uint32_t	ih_ep;		/* Entry Point Address		*/
	uint32_t	ih_dcrc;	/* Image Data CRC Checksum	*/
	uint8_t		ih_os;		/* Operating System		*/
	uint8_t		ih_arch;	/* CPU architecture		*/
	uint8_t		ih_type;	/* Image Type			*/
	uint8_t		ih_comp;	/* Compression Type		*/
	uint8_t		ih_name[IH_NMLEN];	/* Image Name		*/
};

void do_usage(int argc, const char **argv)
{
    printf("Usage: %s <u-boot.bin> [output_file]\n", argv[0]);
}

#define BUF_SIZE (10 * 1024 * 1024)
static uint8_t file_buf[BUF_SIZE] = {0};

int dump_buf(uint8_t *buf, size_t len, uint32_t offset, int dump_len)
{
    uint32_t payload_offset = offset;

    uint32_t *ptr = (uint32_t *)(file_buf + payload_offset);

    int data_per_line = 4;

    for (int i=0; i < dump_len; i++) {

        if (i != 0 && i % data_per_line == 0) {
            printf("\n");
        }
        if (i % data_per_line == 0) {
            printf("0x%08x :", payload_offset);
            payload_offset += sizeof(payload_offset) * data_per_line;
        }
        printf("0x%08x ", *ptr++);
    }

    return 0;
}

int main(int argc, const char **argv)
{
    // uint32_t crc = crc32(test_data, strlen(test_data));
    // printf("crc32 : 0x%x\n", crc);

    if (argc < 2) {
        do_usage(argc, argv);
        return 0;
    }

    /*
     * normal workflow, open the file get the fixed crc then
     * read payload into the buffer and call the crc routine,
     * compare the result finally */

    FILE *fp = fopen(argv[1], "r");
    fread(file_buf, BUF_SIZE, 1, fp);
    fclose(fp);

    struct legacy_img_hdr *header = (struct legacy_img_hdr *)(file_buf + 0x8000);

	printf("image header infomation :\n");
	printf("\t ih_magic;  -->> 0x%x /* Image Header Magic Number  */  \n", header->ih_magic);
	printf("\t ih_hcrc;  -->> 0x%x /* Image Header CRC Checksum  */  \n", header->ih_hcrc);
	printf("\t ih_time;  -->> 0x%x /* Image Creation Timestamp	*/    \n", header->ih_time);
	printf("\t ih_size;  -->> 0x%x /* Image Data Size		*/        \n", header->ih_size);
	printf("\t ih_load;  -->> 0x%08x /* Data	 Load  Address		*/    \n", header->ih_load);
	printf("\t ih_ep;	  -->> 0x%08x /* Entry Point Address		*/    \n", header->ih_ep);
	printf("\t ih_dcrc;  -->> 0x%x /* Image Data CRC Checksum	*/    \n", header->ih_dcrc);
	printf("\t ih_os;	  -->> 0x%x /* Operating System		*/        \n", header->ih_os);
	printf("\t ih_arch;  -->> 0x%x /* CPU architecture		*/        \n", header->ih_arch);
	printf("\t ih_type;  -->> 0x%x /* Image Type			*/        \n", header->ih_type);
	printf("\t ih_comp;  -->> 0x%x /* Compression Type		*/        \n", header->ih_comp);
	printf("\t ih_name   -->> %s   /* Image Name		*/            \n", header->ih_name);

    #define __be32_to_cpu(x) __builtin_bswap32((x))
    #define be32_to_cpu __be32_to_cpu
    #define uimage_to_cpu(x)		be32_to_cpu(x)

    uint32_t data_size = uimage_to_cpu(header->ih_size);
    printf("data load addr : 0x%x\n", uimage_to_cpu(header->ih_load));
    printf("entry point addr : 0x%x\n", uimage_to_cpu(header->ih_ep));
    printf("data size : 0x%x\n", data_size);

    #define SYS_UBOOT_OFFSET 0x8000

    uint8_t *ptr = (uint8_t *)(file_buf + SYS_UBOOT_OFFSET + sizeof(struct legacy_img_hdr));

    /* from 0x8040 to 0x6867a */
    int fd_payload = open("./payload.bin", O_WRONLY);
    write(fd_payload, ptr, data_size);
    close(fd_payload);

    /* one more step. dump the payload.bin */
#if 0
    fd_payload = open("./payload.bin", O_RDONLY);
    lseek(fd_payload, data_size - 8, SEEK_SET);
    uint8_t dump_byte;
    read(fd_payload, &dump_byte, 1);
    printf("%02x\n", dump_byte);
#endif
    extern uint32_t crc32(uint32_t crc, const uint8_t *p, uint32_t len);

    uint32_t crc = crc32(0, ptr, data_size);
    printf("crc of payload : 0x%08x\n\n", crc);

    if (crc == header->ih_dcrc)
        puts("SPL: Image data CRC check Okay!");
    else
        puts("SPL: Image data CRC check is failed!");

    return 0;
}

