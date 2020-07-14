/**
 * This class is used to score alignments. 
 * 
 * TODO: You are to implement the two score() methods.
 * 
 * @author <Keaghan Knight ktknight>
 */

public class Judge {

  public static final int DEFAULT_MATCH_COST = 2;
  public static final int DEFAULT_MISMATCH_COST = -2;
  public static final int DEFAULT_GAP_COST = -1;
  
  private int matchCost, mismatchCost, gapCost;
  
  /**
   * Creates the default judge.
   */
  public Judge() {
    this(DEFAULT_MATCH_COST, DEFAULT_MISMATCH_COST, DEFAULT_GAP_COST);
  }
  
  /**
   * Creates a judge using the specified costs.
   */
  public Judge(int matchCost, int mismatchCost, int gapCost) {
    this.matchCost = matchCost;
    this.mismatchCost = mismatchCost;
    this.gapCost = gapCost;
  }
  
  /**
   * Returns the gap cost used by this judge.
   */
  public int getGapCost() {
    return gapCost;
  }
  
  /**
   * Returns the match cost used by this judge.
   */
  public int getMatchCost() {
    return matchCost;
  }
  
  /**
   * Returns the mismatch cost used by this judge.
   */
  public int getMismatchCost() {
    return mismatchCost;
  }

  /**
   * @param a
   * @param b
   * @return the score associated with a and b
   */
  public int score(char a, char b) {
    if(a == '_' || b == '_')
      return gapCost;
    else if(a == b)
      return matchCost;
    return mismatchCost;
  }

  /**
   * @param s1
   * @param s2
   * @return the score associated with s1 and s2
   * @throws IllegalArgumentException if s1 and s2
   * are not of equal length
   * Calls score(char, char)
   */
  public int score(String s1, String s2) {
    if(s1.length() != s2.length())
      throw new IllegalArgumentException();
    int score = 0;
    for(int i = 0; i < s1.length(); i++)
      score += score(s1.charAt(i), s2.charAt(i));
    return score;
  }
}
