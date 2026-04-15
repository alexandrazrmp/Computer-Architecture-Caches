# MIPS Cache & Memory Hierarchy Analysis

## Overview
This project was developed for the course Computer Architecture II.

The goal is to evaluate memory hierarchy performance of MIPS processors using the Roofline model.

---

## Problem Description

Three computational tasks were implemented in MIPS assembly:

1. Vector-scalar multiplication
2. Matrix-scalar multiplication
3. Matrix-matrix multiplication

- Data stored in memory (no I/O)
- Integer arithmetic with overflow detection
- Tested for n = 8, 16, 32

---

## CPUs Evaluated

### MIPS-A
- 5-stage pipeline
- No cache
- 100 MHz
- Memory latency: 60 cycles

### MIPS-B
- Same pipeline
- L1 Instruction Cache (8KB)
- L1 Data Cache (8KB)

### MIPS-C
- Same as MIPS-B
- + L2 Cache (64KB)
- L2 latency: 6 cycles

---

## Methodology

- Simulated using QtMips
- Tested multiple cache configurations:
  - Block sizes: 2, 4, 8 words
  - Associativity: 1, 2, 4
- Measured:
  - CPI (Cycles Per Instruction)
  - Performance (Multiplications per second)
  - Arithmetic Intensity (Multiplications per byte)

---

## Key Findings

### Cache Effects
- Larger block sizes (8 words) → fewer cache misses
- Spatial locality significantly improves performance

### MIPS-A
- Very poor performance
- Bottleneck: main memory latency

### MIPS-B
- Major improvement due to L1 cache
- Best performance overall for tested workloads

### MIPS-C
- L2 cache adds overhead for small datasets
- Not beneficial for n = 8–32
- Would help for larger datasets

---

## Roofline Insights

- MIPS-A is memory-bound
- MIPS-B shifts closer to compute-bound
- MIPS-C shows no advantage due to small workload size

---

## Conclusion

Best configuration:

→ MIPS-B with block size = 8

Reason:
- Optimal balance between cache efficiency and latency
- L2 cache not useful for small problem sizes

---

## Files

- ProgramA.s (for all configurations n = 8, 16, 32...)
- ProgramB.s
- ProgramC.s
- report.pdf

---

## Authors

- Iasonas Karaprodromidis
- Alexandra Zorba
