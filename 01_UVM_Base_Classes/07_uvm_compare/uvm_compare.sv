// Packet class derived from uvm_object
class packet extends uvm_object;

  // 8-bit address field
  rand bit [7:0] addr;

  // Begin field automation registration
  `uvm_object_utils_begin(packet)

    // Register addr field for automatic
    // print, copy, clone, compare, pack and unpack operations
    `uvm_field_int(addr, UVM_ALL_ON)

  // End field automation registration
  `uvm_object_utils_end

  // Constructor
  function new(string name = "packet");
    super.new(name);
  endfunction

endclass

module tb;

  // Handles for packet objects
  packet pkt1;
  packet pkt2;

  initial begin

    // Create packet objects using the UVM factory
    pkt1 = packet::type_id::create("pkt1");
    pkt2 = packet::type_id::create("pkt2");

    // Assign values for comparison
    pkt1.addr = 25;
    pkt2.addr = 25;

    // Compare all registered fields
    // compare() returns 1 if all registered fields match
    if (pkt1.compare(pkt2))
      $display("MATCH");
    else
      $display("MISMATCH");

  end

endmodule

