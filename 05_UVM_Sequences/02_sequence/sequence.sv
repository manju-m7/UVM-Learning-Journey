class packet extends uvm_sequence_item;

  // Register the packet with the UVM factory
  `uvm_object_utils(packet)

  // Random transaction fields
  rand bit [7:0] addr;
  rand bit [7:0] data;
  rand bit write;

  // Constructor
  function new(string name = "packet");
    super.new(name);
  endfunction

endclass


class my_sequence extends uvm_sequence #(packet);

  // Register the sequence with the UVM factory
  `uvm_object_utils(my_sequence)

  // Handle for the sequence item
  packet pkt;

  // Constructor
  function new(string name = "my_sequence");
    super.new(name);
  endfunction

  // Task executed when the sequence starts
  task body();

    // Create the sequence item
    pkt = packet::type_id::create("pkt");

    // Assign values to the transaction
    pkt.addr  = 8'h25;
    pkt.data  = 8'h64;
    pkt.write = 1'b1;

    // Display the generated transaction
    $display("Sequence Generated Transaction");
    $display("Address = %0h", pkt.addr);
    $display("Data    = %0h", pkt.data);
    $display("Write   = %0b", pkt.write);

  endtask

endclass


module tb;

  my_sequence seq;

  initial begin

    // Create the sequence
    seq = my_sequence::type_id::create("seq");

    // Execute the body() task directly
    seq.body();

  end

endmodule