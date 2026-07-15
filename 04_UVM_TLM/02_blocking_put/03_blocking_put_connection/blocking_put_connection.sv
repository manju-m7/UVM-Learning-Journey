class producer extends uvm_component;

  // Register the producer with the UVM factory
  `uvm_component_utils(producer)

  // Blocking put port used to send integer transactions
  uvm_blocking_put_port #(int) put_port;

  // Constructor
  function new(string name = "producer", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the blocking put port
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the blocking put port
    put_port = new("put_port", this);
  endfunction

  // Run phase used to send data
  task run_phase(uvm_phase phase);

    // Raise objection to keep simulation alive
    phase.raise_objection(this);

    // Display the value being sent
    $display("Producer sending data = 100");

    // Send data through the blocking put port
    put_port.put(100);

    // Drop objection after sending data
    phase.drop_objection(this);

  endtask

endclass


class consumer extends uvm_component;

  // Register the consumer with the UVM factory
  `uvm_component_utils(consumer)

  // Blocking put implementation used to receive integer transactions
  uvm_blocking_put_imp #(int, consumer) put_imp;

  // Constructor
  function new(string name = "consumer", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the blocking put implementation
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the blocking put implementation
    put_imp = new("put_imp", this);
  endfunction

  // Task automatically called when data is received
  task put(int data);

    // Display the received value
    $display("Consumer received data = %0d", data);

  endtask

endclass


class my_test extends uvm_test;

  // Register the test with the UVM factory
  `uvm_component_utils(my_test)

  // Handles for producer and consumer
  producer prod;
  consumer cons;

  // Constructor
  function new(string name = "my_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create components
  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    // Create producer
    prod = producer::type_id::create("prod", this);

    // Create consumer
    cons = consumer::type_id::create("cons", this);

  endfunction

  // Connect producer and consumer
  function void connect_phase(uvm_phase phase);

    super.connect_phase(phase);

    // Connect producer's port to consumer's implementation
    prod.put_port.connect(cons.put_imp);

  endfunction

endclass


module tb;

  initial begin

    // Start the UVM test
    run_test("my_test");

  end

endmodule