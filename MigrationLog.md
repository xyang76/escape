# =================================================
# Popcorn Linux 5.2.21 -> Linux 6.18.52 Migration Logs
# =================================================

Status:
- TODO: Not started
- MISMATCH: Version mismatch, need work out later
- IN PROGRESS: Currently being migrated
- DONE: Migrated and verified

---
# 01. Core / Build / Kconfig: DONE (Sep 18, 2026)
- Description: Popcorn-boot related parts.

# 02. Popcorn Defs:  DONE (Oct 2, 2026)
* Popcorn def folder: popcorn-kernel/include/popcorn
* Task: popcorn-kernel/include/linux/sched.h
* Syscall: popcorn-kernel/include/linux/syscalls.h
    - Description: Xin, added ifdef CONFIG_POPCORN for code robustness
* Syscall: popcorn-kernel/include/uapi/asm-generic/unistd.h
    - Description: seems okay as removed __NR_syscalls 470
* popcorn-kernel/include/uapi/asm-generic/mman-common.h
    - Description: updated MADV_RELEASE value from 20 to 901, since 20 is used for MADV_COLD in linux 6.18
* Page: popcorn-kernel/arch/x86/include/asm/page_64_types.h
    - Description: Popcorn seems used the virtual address space to 38 bits, updated fun: default_map_window
* MM: popcorn-kernel/mm/internal.h
* Memory: popcorn-kernel/include/linux/mm_types.h
* MM: popcorn-kernel/include/linux/mm.h
* Memory: popcorn-kernel/mm/memory.c
    - Description: modified __get_fault_gfp_mask for pass kernel compilation

# 03. Missing Defs: MISMATCH
popcorn-kernel/arch/x86/include/asm/pgtable-2level.h
popcorn-kernel/arch/x86/include/asm/pgtable-3level.h
popcorn-kernel/arch/x86/include/asm/pgtable.h

==> OCT 4, 2026 defs compilation passed. [github version: 1ff85d2]

# 04. Popcorn Kernel:  DONE (Oct 4, 2026)
TODO: popcorn-kernel/arch/x86/include/asm/pgtable_64.h remove  #include <asm/pgtable-invert.h>

