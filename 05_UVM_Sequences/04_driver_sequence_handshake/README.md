# UVM Sequences - Driver Sequence Handshake

## Objective

The objective of this example is to understand how a UVM driver communicates with a sequencer using the driver-sequencer handshake.

This handshake ensures that transactions are transferred in a controlled manner between the sequencer and the driver.

---

## Concepts Covered

- `uvm_driver`
- Driver-Sequencer Handshake
- `seq_item_port`
- `get_next_item()`
- `item_done()`

---

## What is the Driver-Sequencer Handshake?

The driver does not automatically receive transactions from the sequencer.

Instead, the driver explicitly requests a transaction using `get_next_item()`.

After processing the transaction, the driver informs the sequencer that it has finished by calling `item_done()`.

---

## Handshake Flow

```text
Sequence
    |
Packet
    |
Sequencer
    |
get_next_item()
    |
Driver
    |
Drive DUT
    |
item_done()
    |
Sequencer
```

---

## Understanding the Example

The driver extends `uvm_driver #(packet)`.

Inside the `run_phase()`:

1. The driver requests a transaction using `get_next_item()`.
2. The transaction fields are displayed.
3. The driver informs the sequencer that processing is complete using `item_done()`.

This example focuses only on the handshake mechanism.

A complete sequence, sequencer, and driver connection will be introduced in the following examples.

---

## Why are get_next_item() and item_done() Important?

### get_next_item()

Requests the next available transaction from the sequencer.

### item_done()

Notifies the sequencer that the driver has completed processing the current transaction.

Together, these methods synchronize transaction flow between the sequencer and the driver.

---

## Key Takeaways

- The driver requests transactions using `get_next_item()`.
- The driver must call `item_done()` after completing a transaction.
- This handshake ensures synchronized communication between the sequencer and the driver.
- These methods are used in almost every UVM driver.

---
