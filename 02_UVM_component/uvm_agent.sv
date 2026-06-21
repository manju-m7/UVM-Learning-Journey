// Agent class derived from uvm_agent
class my_agent extends uvm_agent;

  // Register the agent with the UVM factory
  `uvm_component_utils(my_agent)

  // Constructor
  function new(
    string name = "my_agent",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

endclass


// Environment class derived from uvm_env
class my_env extends uvm_env;

  // Register the environment with the UVM factory
  `uvm_component_utils(my_env)

  // Handle for agent
  my_agent agent;

  // Constructor
  function new(
    string name = "my_env",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

  // Build phase used to create child components
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create agent and assign this environment
    // as the parent component
    agent = my_agent::type_id::create("agent", this);
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

  // Build phase used to create environment
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