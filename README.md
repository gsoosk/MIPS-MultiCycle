# MIPS-MultiCycle
A Multi Cycle implementation of MIPS
* [SingleCycle version](https://github.com/gsoosk/MIPS-SingleCycle)
* [A SingleCycle version with PipeLine](https://github.com/gsoosk/MIPS-PipeLine)

## How it works ? 

This CPU have an `8bit` data bus and a `13bit` address bus.
All of Instruction are 8 or 16 bit.
This CPU have these registers : 
* 4 Accumulator registers (AC0, AC1, AC2, AC3) that contains CPU register file 
* 1 13bits register named Temporary (TR)
* 1 5bits register named Direction Register (DI)
* 1 3bits rgister named Status Register (CZN)
* 1 8bits ALU

| Instruction Mnemonic and Definition |                 | Bits 7:4 | RTL Notation                      |
|-------------------------------------|-----------------|----------|-----------------------------------|
| LDA                                 | Load Addressed  | 0        | Aci <- (Address)                  |
| STA                                 | Store Addressed | 1        | (Address) <- Aci                  |
| ADA                                 | Add Addressed   | 10       | Aci <- Aci + (Address) + C        |
| ANA                                 | AND Addressed   | 11       | Aci <- Aci & (Address)            |
| MVR                                 | Move Registers  | 1000     | Aci <- Acj                        |
| ADR                                 | Add Registers   | 1001     | Aci <-Aci +Acj +C                 |
| ANR                                 | AND Registers   | 1010     | Aci <- Aci & Acj                  |
| ORR                                 | OR Registers    | 1011     | Aci <- Aci | Acj                  |
| JMP                                 | Jump Addressed  | 110      | PC <-Addres based on flags and DI |
| LDI                                 | Load Direction  | 111      | DI <- IR[4:0]                     |
