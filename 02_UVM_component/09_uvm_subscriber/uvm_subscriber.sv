// Transaction class derived from uvm_sequence_item
class packet extends uvm_sequence_item;

  // Register the transaction with the UVM factory
  `uvm_object_utils(packet)

  // Constructor
  function new(string name = "packet");
    super.new(name);
  endfunction

endclass


// Subscriber class derived from uvm_subscriber
// Receives transactions of type packet
class my_subscriber extends uvm_subscriber #(packet);

  // Register the subscriber with the UVM factory
  `uvm_component_utils(my_subscriber)

  // Constructor
  function new(
    string name = "my_subscriber",
    uvm_component parent = null
  );
    super.new(name, parent);
  endfunction

  // This method is automatically called whenever
  // a packet transaction is received
  function void write(packet t);
    $display("Transaction received");
  endfunction

endclass


// Environment class derived from uvm_env
class my_env extends uvm_env;

  // Register the environment with the UVM factory
  `uvm_component_utils(my_env)

  // Handle for subscriber
  my_subscriber sub;

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

    // Create subscriber as a child of the environment
    sub = my_subscriber::type_id::create("sub", this);
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

