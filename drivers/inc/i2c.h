#ifndef I2C_H
#define I2C_H

#include <stdint.h> 

/* Registers will all use IIC1  
   IIC = I2C, following the reference manual
   for documentation's sake
*/

/* I2C Bus Control Register 1 */
#define IIC1_ICCR1 (*(volatile uint8_t*)0x40053100) 
/* I2C Bus Control Register 2 */
#define IIC1_ICCR2 (*(volatile uint8_t*)0x40053101)

/* I2C Bus Mode Register 1 */
#define IIC1_ICMR1 (*(volatile uint8_t*)0x40053102)
/* I2C Bus Mode Register 2 */
#define IIC1_ICMR2 (*(volatile uint8_t*)0x40053103)
/* I2C Bus Mode Register 3 */
#define IIC1_ICMR3 (*(volatile uint8_t*)0x40053104)

/* I2C Bus Function Enable Register */
#define IIC1_ICFER (*(volatile uint8_t*)0x40053105)
/* I2C Bus Status Enable Register */
#define IIC1_ICSER (*(volatile uint8_t*)0x40053106)
/* I2C Bus Interrupt Enable Register */
#define IIC1_ICIER (*(volatile uint8_t*)0x40053107)

/* I2C Bus Status Register 1 */
#define IIC1_ICSR1 (*(volatile uint8_t*)0x40053108)
/* I2C Bus Status Register 2 */
#define IIC1_ICSR2 (*(volatile uint8_t*)0x40053109)


/* I2C Bus Bit Rate Low-Level Register */
#define IIC1_ICBRL (*(volatile uint8_t*)0x40053110)
/* I2C Bus Bit Rate High-Level Register */
#define IIC1_ICBRH (*(volatile uint8_t*)0x40053111)
/* I2C Bus Transmit Data */
#define IIC1_ICDRT (*(volatile uint8_t*)0x40053112)
/* I2C Bus Receive Data Register */
#define IIC1_ICDRR (*(volatile uint8_t*)0x40053113)


/* I2C API Functions */

/* configure pins & enable the I2C peripheral */
void i2c_init();

/* sends an array of bytes to a specific device address */
uint8_t i2c1_write(uint8_t device_addr, uint8_t* data, uint16_t length);

/* reads an array of bytes from a specific device address */
uint8_t i2c1_read(uint8_t device_addr, uint8_t* data, uint16_t length);

/* writes a single byte to a specific register's device */
uint8_t i2c1_write_reg(uint8_t device_addr, uint8_t reg_addr, uint8_t value);




#endif // I2C_H