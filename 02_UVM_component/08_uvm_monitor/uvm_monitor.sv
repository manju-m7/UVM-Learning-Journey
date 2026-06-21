// Monitor class derived from uvm_monitor
class my_monitor extends uvm_monitor;
  
  // Register the monitor with the UVM factory
  `uvm_component_utils(my_monitor)
  
  // Constructor
  function new (string name = "my_monitor",
                uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
endclass


// Driver class derived from uvm_driver
class my_driver extends uvm_driver;
  
  // Register the driver with the UVM factory
  `uvm_component_utils(my_driver)
  
  // Constructor
  function new (string name = "my_driver",
                uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
endclass


// Agent class derived from uvm_agent
class my_agent extends uvm_agent;
  
  // Register the agent with the UVM factory
  `uvm_component_utils(my_agent)
  
  // Handles for driver and monitor
  my_driver drv;
  my_monitor mon;
  
  // Constructor
  function new(string name = "my_agent",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Build phase used to create child components
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create driver and monitor as children of the agent
    drv = my_driver::type_id::create("drv", this);
    mon = my_monitor::type_id::create("mon", this);
  endfunction
  
endclass


// Environment class derived from uvm_env
class my_env extends uvm_env;
  
  // Register the environment with the UVM factory
  `uvm_component_utils(my_env)
  
  // Handle for agent
  my_agent agent;
  
  // Constructor
  function new(string name = "my_env",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Build phase used to create child components
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create agent as a child of the environment
    agent = my_agent::type_id::create("agent", this);
  endfunction
  
endclass


// User-defined test class derived from uvm_test
class my_test extends uvm_test;
  
  // Register the test with the UVM factory
  `uvm_component_utils(my_test);
  
  // Handle for environment
  my_env env;
  
  // Constructor
  function new(string name = "my_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Build phase used to create environment
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create environment as a child of the test
    env = my_env::type_id::create("env", this);
  endfunction
  
  // Print the complete UVM hierarchy after
  // all components have been created
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