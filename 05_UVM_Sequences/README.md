# UVM Sequences

## Objective

The objective of this section is to understand how transactions are generated and delivered to the driver using UVM Sequences.

Sequences generate sequence items (transactions), which are sent to the sequencer. The sequencer forwards them to the driver, allowing the driver to focus only on driving transactions to the DUT.

---

## Concepts Covered

- Sequence Item
- Sequence
- Sequencer
- Driver-Sequence Communication
- Transaction Generation
- Sequence Execution

---

## Why Do We Need Sequences?

In a UVM testbench, the driver is responsible for driving transactions to the DUT.

However, the driver should not create those transactions.

Instead, a separate component called a **Sequence** generates transactions and sends them through the sequencer.

This separation improves modularity and reusability.

---

## Communication Flow

```text
Sequence
    |
Sequence Item
    |
Sequencer
    |
Driver
    |
DUT
```

---

## What is a Sequence Item?

A sequence item is a transaction object that contains information such as:

- Address
- Data
- Read/Write Control
- Commands

It represents a single operation to be performed on the DUT.

---

## What is a Sequence?

A sequence generates one or more sequence items.

It defines the order and type of transactions that will be executed during simulation.

---

## Learning Path

This section is divided into the following examples:

### 01_sequence_item

Learn how to create a transaction object.

### 02_sequence

Learn how to generate transactions.

### 03_sequencer

Learn the role of the sequencer.

### 04_driver_sequence_handshake

Understand how the driver communicates with the sequencer.

### 05_start_sequence

Learn how to start a sequence.

### 06_complete_sequence_flow

Build a complete sequence → sequencer → driver communication flow.

---

## Key Takeaways

- A sequence generates transactions.
- A sequence item represents a single transaction.
- The sequencer forwards transactions to the driver.
- The driver drives transactions to the DUT.
- Sequences improve reusability by separating transaction generation from transaction execution.
---

