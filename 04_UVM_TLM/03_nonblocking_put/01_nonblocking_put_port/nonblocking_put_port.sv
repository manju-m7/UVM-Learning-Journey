class producer extends uvm_component;

  // Register the producer with the UVM factory
  `uvm_component_utils(producer)

  // Nonblocking put port used to send integer transactions
  uvm_nonblocking_put_port #(int) put_port;

  // Constructor
  function new(string name = "producer",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the nonblocking put port
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the nonblocking put port
    put_port = new("put_port", this);

  endfunction

endclass


class my_test extends uvm_test;

  // Register the test with the UVM factory
  `uvm_component_utils(my_test)

  // Handle for producer component
  producer prod;

  // Constructor
  function new(string name = "my_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the producer
  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    prod = producer::type_id::create(
             "prod",
             this);

  endfunction

  // Print the UVM hierarchy
  function void end_of_elaboration_phase(
                    uvm_phase phase);

    uvm_top.print_topology();

  endfunction

endclass

module tb;

  initial begin

    // Start the UVM test
    run_test("my_test");

  end

endmodule