# UVM TLM - Blocking Put

## Objective

The objective of this section is to understand the Blocking Put communication mechanism in UVM.

Blocking Put enables one UVM component to send transactions to another component using Transaction-Level Modeling (TLM).

This section introduces the producer, consumer, blocking put port, blocking put implementation, and how they are connected.

---

## Concepts Covered

- Blocking Put Communication
- `uvm_blocking_put_port`
- `uvm_blocking_put_imp`
- Producer Component
- Consumer Component
- TLM Connections
- Transaction Transfer

---

## What is Blocking Put?

Blocking Put is a point-to-point communication mechanism used in UVM TLM.

A producer sends a transaction to a consumer through a blocking put port.

The producer waits until the consumer accepts the transaction before continuing execution.

---

## Why is it Called "Blocking"?

When the producer sends data, it does not continue executing immediately.

Instead, it waits until the consumer successfully receives the transaction.

```text
Producer
    |
put(data)
    |
(wait)
    |
Consumer accepts data
    |
Producer continues
```

This waiting behavior is why it is called **Blocking Put**.

---

## Components Involved

### Producer

The producer sends transactions using:

- `uvm_blocking_put_port`

---

### Consumer

The consumer receives transactions using:

- `uvm_blocking_put_imp`

The consumer must also implement the `put()` method, which is automatically called whenever a transaction is received.

---

## Communication Flow

```text
Producer
    |
Blocking Put Port
    |
Connection
    |
Blocking Put Implementation
    |
Consumer
```

The producer sends data through the blocking put port.

The connection forwards the transaction to the blocking put implementation.

The consumer receives the transaction through its `put()` method.

---

## Blocking Put Workflow

```text
Producer
    |
put_port.put(data)
    |
Connection
    |
put_imp
    |
Consumer.put(data)
```

---

## Example Data Flow

```text
Producer sends:

100

        |
        v

Consumer receives:

100
```

---

## Learning Path

This section is divided into three examples.

### 01_blocking_put_port

Introduces the producer side of Blocking Put communication.

Topics covered:

- Declaring a blocking put port
- Creating the port
- Understanding the sender side

---

### 02_blocking_put_imp

Introduces the consumer side of Blocking Put communication.

Topics covered:

- Declaring a blocking put implementation
- Implementing the `put()` method
- Understanding the receiver side

---

### 03_blocking_put_connection

Combines the producer and consumer.

Topics covered:

- Connecting the port and implementation
- Sending transactions
- Receiving transactions
- Complete Blocking Put communication

---

## Key Takeaways

- Blocking Put is a point-to-point TLM communication mechanism.
- A producer sends transactions using `uvm_blocking_put_port`.
- A consumer receives transactions using `uvm_blocking_put_imp`.
- The `put()` method processes incoming transactions.
- The producer waits until the consumer accepts the transaction.
- Blocking Put is commonly used for one-to-one communication in UVM.
---

