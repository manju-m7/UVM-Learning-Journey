# UVM Components - UVM Test Example
## Objective
The objective of this example is to understand the role of `uvm_test` in a UVM verification
environment.
This example demonstrates how a UVM test is registered with the factory and started using
`run_test()`.
---
## Concepts Covered
- `uvm_test`
- UVM Factory
- `uvm_component_utils`
- `run_test()`
- Top-Level Verification Component
---
## What is uvm_test?
`uvm_test` is the top-level verification component in a UVM environment.
Every UVM simulation starts with a test. The test acts as the entry point to the verification
environment and is responsible for creating and controlling lower-level components such as
environments, agents, drivers, and monitors.
---
## Understanding the Example
A user-defined test named `my_test` is created by extending `uvm_test`.
The test is registered with the UVM factory using the component utility macro.
The simulation is started using:
```text
run_test("my_test")
```
When simulation begins, UVM locates the registered test, creates it through the factory, and starts
the UVM phase mechanism.
---
## How run_test() Works
The statement:
```text
run_test("my_test")
```
performs the following steps:
1. Searches for a test named `my_test`
2. Creates the test using the UVM factory
3. Starts UVM phase execution
This is the standard mechanism used to start UVM simulations.
---
## Hierarchy
```text
tb
|
+-- my_test
```
In future examples, the test will create additional components:
```text
tb
|
+-- my_test
|
+-- env
|
+-- agent
```

---
## Simulation Output
![Simulation Output](uvm_test.png)
---
## Key Takeaways
- Every UVM simulation starts with a test.
- `uvm_test` is the top-level verification component.
- Tests are created through the UVM factory.
- `run_test()` is used to start UVM simulations.
- Tests typically create and configure environments.
- Multiple tests can reuse the same verification environment while executing different scenarios.
---