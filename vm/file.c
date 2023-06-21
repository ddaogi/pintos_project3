/* file.c: Implementation of memory backed file object (mmaped object). */

#include "vm/vm.h"
#include "userprog/process.h"
#include "threads/vaddr.h"

static bool file_backed_swap_in (struct page *page, void *kva);
static bool file_backed_swap_out (struct page *page);
static void file_backed_destroy (struct page *page);

/* DO NOT MODIFY this struct */
static const struct page_operations file_ops = {
	.swap_in = file_backed_swap_in,
	.swap_out = file_backed_swap_out,
	.destroy = file_backed_destroy,
	.type = VM_FILE,
};

/* The initializer of file vm */
void
vm_file_init (void) {
}

/* Initialize the file backed page */
bool
file_backed_initializer (struct page *page, enum vm_type type, void *kva) {
	/* Set up the handler */
	page->operations = &file_ops;

	struct file_page *file_page = &page->file;
}

/* Swap in the page by read contents from the file. */
static bool
file_backed_swap_in (struct page *page, void *kva) {
	struct file_page *file_page UNUSED = &page->file;
}

/* Swap out the page by writeback contents to the file. */
static bool
file_backed_swap_out (struct page *page) {
	struct file_page *file_page UNUSED = &page->file;
}

/* Destory the file backed page. PAGE will be freed by the caller. */
static void
file_backed_destroy (struct page *page) {
	struct file_page *file_page UNUSED = &page->file;
}

/* Do the mmap 
*/
void *
do_mmap (void *addr, size_t length, int writable, struct file *file, off_t offset) {
	
	struct file *re_file = file_reopen(file);
	// uint32_t read_bytes = file_length(re_file);
	uint32_t read_bytes = file_length(re_file);
	// uint32_t zero_bytes = (ROUND_UP(page_offset + phdr.p_memsz, PGSIZE) - read_bytes);

	// uint32_t zero_bytes = read_bytes % PGSIZE;
	void* init_addr = addr;
	void* upage = addr;
	
	while(read_bytes >0 /* || zero_bytes >0 */){
		size_t page_read_bytes = read_bytes < PGSIZE ? read_bytes : PGSIZE;

		struct aux_struct* aux = malloc(sizeof(struct aux_struct));
		aux->file = re_file;
		aux->offset = offset;
		aux->page_read_bytes = page_read_bytes;
      	// size_t page_zero_bytes = PGSIZE - page_read_bytes;
		
		vm_alloc_page_with_initializer(VM_FILE, upage, writable, lazy_load_segment, aux);	
		struct page* temp_p = upage;
		
		// vm_claim_page(upage);
		read_bytes -= page_read_bytes;
      	// zero_bytes -= page_zero_bytes;
      	offset+= page_read_bytes;
      	upage += PGSIZE;
	}
	return init_addr;
}

/* Do the munmap */
void
do_munmap (void *addr) {
	while(true){
		
		struct page * temp_p = spt_find_page(&thread_current()->spt,addr);
    	if (temp_p == NULL) {
    		return NULL;
    	}
		struct aux_struct* container = temp_p->uninit.aux;
		if(container->file == NULL) {
			return;
		}
		file_reopen(container->file);
		file_write_at(container->file, addr, container->page_read_bytes, container->offset);	
		file_close(container->file);
		addr+= PGSIZE;
	}
}
