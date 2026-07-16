class packet extends uvm_sequence_item;

  // Register the packet with the UVM factory
  `uvm_object_utils(packet)

  rand int data;

  // Constructor
  function new(string name = "packet");
    super.new(name);
  endfunction

endclass


class my_monitor extends uvm_component;

  // Register the monitor with the UVM factory
  `uvm_component_utils(my_monitor)

  // Analysis port used to broadcast packet transactions
  uvm_analysis_port #(packet) ap;

  // Constructor
  function new(string name = "my_monitor",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase used to create the analysis port
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    ap = new("ap", this);

  endfunction

  // Run phase used to create and broadcast a packet
  task run_phase(uvm_phase phase);

    packet pkt;

    phase.raise_objection(this);

    // Create a packet
    pkt = packet::type_id::create("pkt");

    // Assign a value
    pkt.data = 100;

    $display("Monitor broadcasting packet with data = %0d", pkt.data);

    // Broadcast the packet
    ap.write(pkt);

    phase.drop_objection(this);

  endtask

endclass


class my_subscriber extends uvm_subscriber #(packet);

  // Register the subscriber with the UVM factory
  `uvm_component_utils(my_subscriber)

  // Constructor
  function new(string name = "my_subscriber",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Automatically called when a packet is received
  function void write(packet t);

    $display("Subscriber received packet with data = %0d", t.data);

  endfunction

endclass


class my_env extends uvm_env;

  // Register the environment with the UVM factory
  `uvm_component_utils(my_env)

  my_monitor mon;
  my_subscriber sub;

  // Constructor
  function new(string name = "my_env",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Create monitor and subscriber
  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    mon = my_monitor::type_id::create("mon", this);
    sub = my_subscriber::type_id::create("sub", this);

  endfunction

  // Connect monitor to subscriber
  function void connect_phase(uvm_phase phase);

    super.connect_phase(phase);

    mon.ap.connect(sub.analysis_export);

  endfunction

endclass


class my_test extends uvm_test;

  // Register the test with the UVM factory
  `uvm_component_utils(my_test)

  my_env env;

  // Constructor
  function new(string name = "my_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Create the environment
  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    env = my_env::type_id::create("env", this);

  endfunction

endclass


module tb;

  initial begin

    // Start the UVM test
    run_test("my_test");

  end

endmodule