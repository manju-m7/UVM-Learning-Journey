// Environment class derived from uvm_env
class my_env extends uvm_env;
  
  // Register the environment with the UVM factory
  `uvm_component_utils(my_env)
  
  // Constructor
  function new(string name = "my_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Run phase is a task phase
  // Simulation time can advance in this phase
  task run_phase(uvm_phase phase);

    // Display run phase execution
    $display("Inside run_phase of my_env");

    // Delay for 10 time units
    #10;

    // Display message after delay
    $display("10 time units completed");

  endtask
  
endclass


// User-defined test class derived from uvm_test
class my_test extends uvm_test;
  
  // Register the test with the UVM factory
  `uvm_component_utils(my_test)
  
  // Handle for environment
  my_env env;
  
  // Constructor
  function new(string name = "my_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Build phase used to create child components
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create environment as a child of the test
    env = my_env::type_id::create("env", this);
  endfunction
  
endclass

module tb;
  
  initial begin

    // Start the UVM test
    run_test("my_test");

  end
  
endmodule