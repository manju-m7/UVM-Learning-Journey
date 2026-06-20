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

    // Create original packet object using the UVM factory
    pkt1 = packet::type_id::create("pkt1");

    // Assign a value to the original object
    pkt1.addr = 25;

    // Create a clone of pkt1
    // clone() returns a uvm_object, so $cast is used
    // to convert it back to a packet handle
    $cast(pkt2, pkt1.clone());

    // Display values after cloning
    $display("After Clone");
    $display("pkt1.addr = %0d", pkt1.addr);
    $display("pkt2.addr = %0d", pkt2.addr);

    // Modify the cloned object's address
    pkt2.addr = 50;

    // Display values after modification
    // This demonstrates that pkt1 and pkt2 are
    // independent objects
    $display("After modifying address of pkt2");
    $display("pkt1.addr = %0d", pkt1.addr);
    $display("pkt2.addr = %0d", pkt2.addr);

  end

endmodule