// Environment class derived from uvm_env
class my_env extends uvm_env;

  // Register the environment with the UVM factory
  `uvm_component_utils(my_env)

  // Constructor
  function new(
    string name = "my_env",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

endclass


// User-defined test class derived from uvm_test
class my_test extends uvm_test;

  // Register the test with the UVM factory
  `uvm_component_utils(my_test)

  // Handle for environment
  my_env env;

  // Constructor
  function new(
    string name = "my_test",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

  // Build phase used to create child components
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create environment and assign this test
    // as the parent component
    env = my_env::type_id::create("env", this);
  endfunction

  // Print the complete UVM hierarchy after
  // all components have been constructed
  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction

endclass

module tb;

  initial begin

    // Start the UVM test
    run_test("my_test");

  end

endmodule