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

  // Build phase executes during the UVM build phase
  // Used to create and configure components
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Display a message indicating execution of env build phase
    $display("Inside build_phase of my_env");
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

  // Build phase executes during the UVM build phase
  // Used to create child components
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create environment as a child of the test
    env = my_env::type_id::create("env", this);

    // Display a message indicating execution of test build phase
    $display("Inside build_phase of my_test");
  endfunction

endclass

module tb;

  initial begin

    // Start the UVM test
    run_test("my_test");

  end

endmodule