class packet extends uvm_sequence_item;

  // Register the packet with the UVM factory
  `uvm_object_utils(packet)

  rand bit [7:0] addr;
  rand bit [7:0] data;

  // Constructor
  function new(string name = "packet");
    super.new(name);
  endfunction

endclass


class my_driver extends uvm_driver #(packet);

  // Register the driver with the UVM factory
  `uvm_component_utils(my_driver)

  // Constructor
  function new(string name = "my_driver",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Run phase demonstrating the handshake
  task run_phase(uvm_phase phase);

    packet req;

    phase.raise_objection(this);

    // Wait for the next transaction
    seq_item_port.get_next_item(req);

    $display("Driver received transaction");

    $display("Address = %0h", req.addr);
    $display("Data    = %0h", req.data);

    // Inform the sequencer that processing is complete
    seq_item_port.item_done();

    phase.drop_objection(this);

  endtask

endclass