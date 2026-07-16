class packet extends uvm_sequence_item;

  // Register the packet with the UVM factory
  `uvm_object_utils(packet)

  // Random transaction fields
  rand bit [7:0] addr;
  rand bit [7:0] data;
  rand bit       write;

  // Constructor
  function new(string name = "packet");
    super.new(name);
  endfunction

endclass


module tb;

  packet pkt;

  initial begin

    // Create the sequence item using the UVM factory
    pkt = packet::type_id::create("pkt");

    // Assign values to the transaction fields
    pkt.addr  = 8'h25;
    pkt.data  = 8'h64;
    pkt.write = 1'b1;

    // Display the transaction
    $display("Address = %0h", pkt.addr);
    $display("Data    = %0h", pkt.data);
    $display("Write   = %0b", pkt.write);

  end

endmodule