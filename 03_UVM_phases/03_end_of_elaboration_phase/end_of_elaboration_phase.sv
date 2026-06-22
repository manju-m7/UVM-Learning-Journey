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

  // Build phase executes before simulation starts
  // Used to create and configure components
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Display build phase execution
    $display("Inside build_phase of my_env");
  endfunction

  // Connect phase executes after build phase
  // Used to connect previously created components
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Display connect phase execution
    $display("Inside connect_phase of my_env");
  endfunction

  // End of elaboration phase executes after
  // build and connect phases are completed
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);

    // Display end of elaboration phase execution
    $display("Inside end_of_elaboration_phase of my_env");
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

    // Create environment as a child of the test
    env = my_env::type_id::create("env", this);

    // Display build phase execution
    $display("Inside build_phase of my_test");
  endfunction

  // Connect phase used to connect components
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Display connect phase execution
    $display("Inside connect_phase of my_test");
  endfunction

  // End of elaboration phase executes after
  // hierarchy construction is completed
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);

    // Display end of elaboration phase execution
    $display("Inside end_of_elaboration_phase of my_test");

    // Print the complete UVM hierarchy
    uvm_top.print_topology();
  endfunction

endclass

module tb;

  initial begin

    // Start the UVM test
    run_test("my_test");

  end

endmodule