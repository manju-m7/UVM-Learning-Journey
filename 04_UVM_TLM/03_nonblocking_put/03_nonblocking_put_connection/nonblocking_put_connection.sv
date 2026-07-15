class producer extends uvm_component;

  // Register the producer with the UVM factory
  `uvm_component_utils(producer)

  // Nonblocking put port used to send integer transactions
  uvm_nonblocking_put_port #(int) put_port;

  // Constructor
  function new(string name = "producer", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the nonblocking put port
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the nonblocking put port
    put_port = new("put_port", this);
  endfunction

  // Run phase used to send data
  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    // Check whether the consumer is ready
    if (put_port.can_put()) begin

      $display("Producer sending data = 100");

      // Attempt to send the transaction
      if (put_port.try_put(100))
        $display("Transaction sent successfully");
      else
        $display("Transaction failed");

    end
    else
      $display("Consumer is not ready");

    phase.drop_objection(this);

  endtask

endclass


class consumer extends uvm_component;

  // Register the consumer with the UVM factory
  `uvm_component_utils(consumer)

  // Nonblocking put implementation used to receive integer transactions
  uvm_nonblocking_put_imp #(int, consumer) put_imp;

  // Constructor
  function new(string name = "consumer", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the implementation
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the nonblocking put implementation
    put_imp = new("put_imp", this);
  endfunction

  // Indicate that the consumer is ready
  function bit can_put();
    return 1;
  endfunction

  // Receive the transaction
  function bit try_put(int data);

    $display("Consumer received data = %0d", data);

    return 1;

  endfunction

endclass


class my_test extends uvm_test;

  // Register the test with the UVM factory
  `uvm_component_utils(my_test)

  producer prod;
  consumer cons;

  // Constructor
  function new(string name = "my_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Create producer and consumer
  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    prod = producer::type_id::create("prod", this);
    cons = consumer::type_id::create("cons", this);

  endfunction

  // Connect the producer and consumer
  function void connect_phase(uvm_phase phase);

    super.connect_phase(phase);

    prod.put_port.connect(cons.put_imp);

  endfunction

endclass


module tb;

  initial begin
    run_test("my_test");
  end

endmodule