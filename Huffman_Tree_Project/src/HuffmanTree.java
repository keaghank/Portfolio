import java.util.Comparator;

/**
 * 
 * A HuffmanTree represents a variable-length code such that the shorter the
 * bit pattern associated with a character, the more frequently that character
 * appears in the text to be encoded.
 */

public class HuffmanTree {
  
  class Node {
    protected char key;
    protected int priority;
    protected Node left, right;
    
    public Node(int priority, char key) {
      this(priority, key, null, null);
    }
    
    public Node(int priority, Node left, Node right) {
      this(priority, '\0', left, right);
    }
    
    public Node(int priority, char key, Node left, Node right) {
      this.key = key;
      this.priority = priority;
      this.left = left;
      this.right = right;
    }
    
    public boolean isLeaf() {
      return left == null && right == null;
    }
  }
  
  protected Node root;

  /**
   * @param charFreqs
   * Creates a HuffmanTree from the given FrequencyTable charFreqs
   * Sorted by a Comparator
   */
  public HuffmanTree(FrequencyTable charFreqs) {
    Comparator<Node> comparator = (x, y) -> {
      /**
       * If the priority of x is less than the priority of y
       * @return -1
       * If the priority of x is greater than the priority of y
       * @return 1
       * Otherwise
       * @return 0
       */
      if(x.priority < y.priority)
        return -1;
      else if(x.priority > y.priority)
        return 1;
      return 0;
    };
    PriorityQueue<Node> forest = new Heap<Node>(comparator);
    charFreqs.forEach((k, v) -> {forest.insert(new Node(v, k));});
    while(forest.size() > 1) {
      Node left = forest.delete();
      Node right = forest.delete();
      int iPriority = left.priority + right.priority;
      Node i = new Node(iPriority, left, right);
      forest.insert(i);
    }
    root = forest.peek();
  }
  
  /**
   * @param bits
   * @return the character associated with the prefix of bits.
   * @throws DecodeException if bits does not match a character in the tree.
   */
  public char decodeChar(String bits) {
    char[] charredBits = bits.toCharArray();
    Node p = root;

    for(int i = 0; i < charredBits.length; i++) {
      if(!p.isLeaf()) {
        if (charredBits[i] == '0')
          p = p.left;
        else if (charredBits[i] == '1')
          p = p.right;
      }
    }

    if(p.key == '\0')
      throw new DecodeException(bits);
    return p.key;
  }
    
  /**
   * @param ch
   * @return The associated bit string of the given character ch
   * Calls lookupHelper
   * @throws EncodeException if the character does not appear in the tree.
   */
  public String lookup(char ch) {
    return lookupHelper(ch, root, "");
  }

  /**
   * Helper function for lookup()
   * @param ch
   * @param p
   * @param result
   * @return Recursively returns a string representation of the bit that
   * is associated with the given character ch
   * @throws EncodeException if the character does not appear in the tree
   */
  public String lookupHelper(char ch, Node p, String result) {
    if (p.isLeaf())
      if (p.key == ch)
        return result;

    String left = "", right = "", max = "";
    if (p.left != null)
      left = lookupHelper(ch, p.left, result + '0');

    if (p.right != null)
      right = lookupHelper(ch, p.right, result + '1');

    if(left.length() > right.length())
      max = left;
    else
      max = right;

    if (p == root && max == "")
      throw new EncodeException(ch);
    return max;
  }
}

