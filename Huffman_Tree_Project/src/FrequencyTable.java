import java.util.HashMap;

/**
 * FrequencyTable is represented by HashMap
 * Associates a character to an count represented by an integer
 */
public class FrequencyTable extends HashMap<Character, Integer> {
  /**
   * Constructs an empty table.
   */
  public FrequencyTable() {
    super();
  }

  /**
   * @param text
   * Constructs a FrequencyTable from the given text
   */
  public FrequencyTable(String text) {
    char[] countChar = text.toCharArray();
    for(Character c : countChar) {
      int count = get(c);
      if(count == 0)
        put(c, 1);
      put(c, count + 1);
    }
  }

  /**
   * @param ch
   * @return the associated count to ch if it exists
   * otherwise return 0
   */
  @Override
  public Integer get(Object ch) {
    if(containsKey(ch))
      return super.get(ch);
    return 0;
  }
}
