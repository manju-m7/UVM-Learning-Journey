class producer extends uvm_component;

  // Register the producer with the UVM factory
  `uvm_component_utils(producer)

  // Analysis port used to broadcast integer transactions
  uvm_analysis_port #(int) ap;

  // Constructor
  function new(string name = "producer",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the analysis port
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the analysis port
    ap = new("ap", this);
  endfunction

  // Run phase used to broadcast data
  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    $display("Producer broadcasting data = 100");

    // Broadcast the transaction
    ap.write(100);

    phase.drop_objection(this);

  endtask

endclass


class subscriber extends uvm_component;

  // Register the subscriber with the UVM factory
  `uvm_component_utils(subscriber)

  // Analysis implementation used to receive integer transactions
  uvm_analysis_imp #(int, subscriber) analysis_imp;

  // Constructor
  function new(string name = "subscriber",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the analysis implementation
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the analysis implementation
    analysis_imp = new("analysis_imp", this);
  endfunction

  // Automatically called when a transaction is broadcast
  function void write(int data);

    $display("Subscriber received data = %0d", data);

  endfunction

endclass


class my_test extends uvm_test;

  // Register the test with the UVM factory
  `uvm_component_utils(my_test)

  producer prod;
  subscriber sub;

  // Constructor
  function new(string name = "my_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create components
  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    prod = producer::type_id::create("prod", this);
    sub  = subscriber::type_id::create("sub", this);

  endfunction

  // Connect the analysis port to the analysis implementation
  function void connect_phase(uvm_phase phase);

    super.connect_phase(phase);

    prod.ap.connect(sub.analysis_imp);

  endfunction

endclass

module tb;

  initial begin
    run_test("my_test");
  end

endmodule