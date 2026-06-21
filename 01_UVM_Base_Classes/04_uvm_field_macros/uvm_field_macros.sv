// Packet class derived from uvm_object 
class packet extends uvm_object;

  // Randomizable 8-bit address field
  rand bit [7:0] addr;

  // Constraint: address value must be between 10 and 20
  constraint c_addr {
    addr inside {[10:20]};
  }

  // Begin field automation registration
  `uvm_object_utils_begin(packet)

    // Register 'addr' with UVM automation features
    // UVM_ALL_ON enables print, copy, compare,
    // pack, unpack, and record operations
    `uvm_field_int(addr, UVM_ALL_ON)

  // End field automation registration
  `uvm_object_utils_end

  // Constructor
  function new(string name = "packet");
    super.new(name);
  endfunction

endclass

module tb;

  // Handle for packet object
  packet pkt;

  initial begin

    // Create packet object using the UVM Factory
    pkt = packet::type_id::create("pkt");

    // Randomize packet fields
    pkt.randomize();

    // Print packet contents
    pkt.print();

  end

endmodule