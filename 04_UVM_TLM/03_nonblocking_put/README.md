# UVM TLM - Nonblocking Put

## Objective

The objective of this section is to understand the Nonblocking Put communication mechanism in UVM.

Unlike Blocking Put, the producer does not wait for the consumer to accept a transaction. Instead, it attempts to send the transaction and immediately continues execution.

---

## Concepts Covered

- Nonblocking Put Communication
- `uvm_nonblocking_put_port`
- `uvm_nonblocking_put_imp`
- `try_put()`
- `can_put()`
- Producer Component
- Consumer Component

---

## What is Nonblocking Put?

Nonblocking Put is a point-to-point communication mechanism used in UVM TLM.

The producer attempts to send a transaction to the consumer.

If the consumer is ready, the transaction is accepted.

If the consumer is not ready, the producer continues without waiting.

---

## Blocking Put vs Nonblocking Put

### Blocking Put

The producer waits until the consumer accepts the transaction.

### Nonblocking Put

The producer attempts to send the transaction and immediately continues execution.

---

## Methods Used

### can_put()

Checks whether the receiver is ready to accept a transaction.

### try_put()

Attempts to send a transaction.

Returns:

- `1` → Transaction accepted
- `0` → Transaction rejected

---

## Communication Flow

```text
Producer
    |
Nonblocking Put Port
    |
Connection
    |
Nonblocking Put Implementation
    |
Consumer
```

---

## Learning Path

This section is divided into three examples.

### 01_nonblocking_put_port

Introduces the producer side of Nonblocking Put communication.

### 02_nonblocking_put_imp

Introduces the consumer side and the required methods.

### 03_nonblocking_put_connection

Connects the producer and consumer to demonstrate nonblocking transaction transfer.

---

## Key Takeaways

- Nonblocking Put provides point-to-point communication.
- The producer does not wait for the consumer.
- `can_put()` checks receiver availability.
- `try_put()` attempts to send a transaction.
- Nonblocking Put is useful when the sender should continue execution regardless of the receiver's state.

---
