<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

# Technical Specification: Quad-Digit Hexadecimal Display System

This system functions as a **hexadecimal visualization peripheral** controlled via a **Serial Peripheral Interface (SPI)** operating in slave mode. It is designed to process and display 16 bits of data, representing four hexadecimal characters.

---

### Data Transmission Protocol
To ensure data integrity and proper synchronization, the following protocol must be observed:

*   **Transaction Structure:** The system expects a single, continuous SPI transaction. The **Chip Select (CS)** line must remain asserted (Low) for the entire duration of the data transfer.
*   **Data Payload:** The primary payload consists of **16 bits** of information, corresponding to the four hexadecimal digits to be displayed.
*   **Extended Configuration:** To modify system parameters, a **third byte** may be appended to the transaction.

### Refresh-Rate Configuration
The display refresh-rate is user-configurable and is determined by the value of the third transmitted byte. 

*   **Input Range:** The refresh-rate parameter ($RR$) accepts an integer value between **0 and 15**.
*   **Computational Logic:** The internal refresh frequency ($f_{refresh}$) is derived from the system clock ($clk$) using a power-of-two prescaler:

$$f_{refresh} = \frac{clk}{2^{RR}}$$

---

### Operational Summary

| Feature | Specification |
| :--- | :--- |
| **Interface** | SPI Slave |
| **Capacity** | 4 Hexadecimal Digits (16 bits) |
| **CS Requirement** | Active Low for duration of transfer (16–24 bits) |
| **Configurability** | Variable Refresh-Rate via 3rd Byte |
| **RR Range** | 0 to 15 |


## How to test

COSO

## External hardware

COSO