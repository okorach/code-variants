# code-variants
SonarQube analysis of different C/C++ code variants

To run this demo:

- Install the [bear](https://github.com/rizsotto/Bear) tool on your machine, to generate compilation databases
  ON mac that would simply require `brew install bear`.
  Installation is recommended but can be skipped, in case of installation difficulties
  since compilation DBs are pre-generated and stored in the repo, in case of any difficulty

- Scan the project with the `sonar-scanner`. This creates a **code-variants** project with a main branch unaware of code variants.
  In effect only the default **x86_64** variant is analyzed.
  0 issues are found in that variant, but a few lines of code are missed

- Now run the `scan-variants.sh` script that is configuring the scanner for multiple variants scanning, 2 in the current case:
  - An imaginary target that's 64 bits and little indian (**x86_64**)
  - An imaginary target that's 32 bits and big indian (**ppc** for PowerPC)

The result of this multiple code variants scan is sent to the `code-variant` branch of SonarQube to easily show the difference in results. This analysis now finds 2 issues in the **ppc** variant
- A division by 0 due to the target (big) endianness
- An integer overflow due to the target 32 bits word size

