# Matrix Multiplication in RISC-V Assembly

This project implements matrix multiplication in RISC-V assembly language. The program reads two matrices from memory, checks their dimensions for compatibility, and computes the resultant matrix if possible.

---

## Overview

### Features:
1. **Matrix Compatibility Check**:
   - Verifies that the number of columns in the first matrix matches the number of rows in the second matrix.
2. **Matrix Multiplication**:
   - Computes the product of two matrices and stores the result in memory.
3. **Error Handling**:
   - If the matrices are not compatible, the result memory will contain zero values to indicate an error.

---

## Code Structure

### Memory Layout:
- **.data Section**:
  - Stores matrix dimensions and data.
  - Example:
    ```
    .dword 2, 2, 2, 2, 1, 2, 3, 4, 1, 2, 3, 4
    ```
    - First four values represent dimensions (rows and columns of both matrices).
    - Remaining values are matrix elements.

- **.text Section**:
  - Implements the matrix multiplication algorithm.

### Key Registers:
- **x3**: Base address of the first matrix.
- **x4**: Base address of the second matrix.
- **x5**: Base address of the result matrix (0x10004000).
- **x12, x13, x14, x15**: Matrix dimensions (rows and columns).
- **x28, x29, x30**: Loop variables (`i`, `j`, `k`).
- **x20**: Accumulator for result computation.

### Result Storage:
- The result matrix starts at memory location **0x10004000**.

---

## Instructions to Run

1. **Assemble the Program**:
   Use an assembler to translate the assembly code into machine code:
   ```bash
   riscv64-unknown-elf-as -o mmult.o mmult.s
