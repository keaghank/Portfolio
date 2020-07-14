import java.util.Random;

/**
 * TODO: Implement the bestResult(), fillCache(), getResult(), and traceback() methods, in
 * that order. This is the biggest part of this project.
 * 
 * @author <Keaghan Knight ktknight>
 */

public class SequenceAligner {
  private static Random gen = new Random();

  private String x, y;
  private int n, m;
  private String alignedX, alignedY;
  private Result[][] cache;
  private Judge judge;

  /**
   * Generates a pair of random DNA strands, where x is of length n and
   * y has some length between n/2 and 3n/2, and aligns them using the 
   * default judge.
   */
  public SequenceAligner(int n) {
    this(randomDNA(n), randomDNA(n - gen.nextInt(n / 2) * (gen.nextInt(2) * 2 - 1)));
  }

  /**
   * Aligns the given strands using the default judge.
   */
  public SequenceAligner(String x, String y) {
    this(x, y, new Judge());
  }
  
  /**
   * Aligns the given strands using the specified judge.
   */
  public SequenceAligner(String x, String y, Judge judge) {
    this.x = x.toUpperCase();
    this.y = y.toUpperCase();
    this.judge = judge;
    n = x.length();
    m = y.length();
    cache = new Result[n + 1][m + 1];
    fillCache();
    traceback();
  }

  /**
   * Returns the x strand.
   */
  public String getX() { return x; }

  /**
   * Returns the y strand.
   */
  public String getY() { return y; }
  
  /**
   * Returns the judge associated with this pair.
   */
  public Judge getJudge() {
    return judge;
  }
  
  /**
   * Returns the aligned version of the x strand.
   */
  public String getAlignedX() {
    return alignedX;
  }

  /**
   * Returns the aligned version of the y strand.
   */
  public String getAlignedY() {
    return alignedY;
  }

  /**
   * @param diag
   * @param left
   * @param up
   * @return The Result of the maxScore of diag, left, and up.
   * Create a new Result of the maxScore, and the corresponding Direction
   * Follows the preferred order of operations of M(diag), I(left), D(up)
   * for the tiebreaking rule.
   */
  public static Result bestResult(int diag, int left, int up) {
    int maxScore = Math.max(diag, Math.max(left, up));
    if(maxScore == diag)
      return new Result(diag, Direction.DIAGONAL);
    else if(maxScore == left)
      return new Result(left, Direction.LEFT);
    return new Result(up, Direction.UP);
  }

  /**
   * Instantiate the cache at (0, 0), where the score is 0 and no Direction
   * Set the first column of the cache with a score based off the GapCost
   * at the current index and a Direction of UP
   * Set the first row of the cache with a score based off the GapCost
   * at the current index and a Direction of LEFT
   * Fill the rest of the cache with the largest score between diag, left, and up
   * (the biggest payoff) and a Direction based on the score with the biggest payoff
   * Follows the preferred order of operations M(diag), I(left), D(up)
   */
  private void fillCache() {
    cache[0][0] = new Result(0, Direction.NONE);
    for(int i = 1; i < cache.length; i++)
      cache[i][0] = new Result((i * judge.getGapCost()), Direction.UP);
    for(int j = 1; j < cache[0].length; j++)
      cache[0][j] = new Result((j * judge.getGapCost()), Direction.LEFT);
    for(int a = 1; a < cache.length; a++) {
      for(int b = 1; b < cache[a].length; b++) {
        int diagonalScore = cache[a-1][b-1].getScore() + judge.score(x.charAt(a-1), y.charAt(b-1));
        int leftScore = cache[a][b-1].getScore() + judge.getGapCost();
        int upScore = cache[a-1][b].getScore() + judge.getGapCost();
        int maxScore = Math.max(diagonalScore, Math.max(leftScore, upScore));

        Direction biggestPayoff = Direction.NONE;
        if(maxScore == diagonalScore)
          biggestPayoff = Direction.DIAGONAL;
        else if(maxScore == leftScore)
          biggestPayoff = Direction.LEFT;
        else if(maxScore == upScore)
          biggestPayoff = Direction.UP;

        cache[a][b] = new Result(maxScore, biggestPayoff);
      }
    }
  }

  /**
   * @param i
   * @param j
   * @return the result in the cache at (i, j)
   * Runs in 0(1) time
   */
  public Result getResult(int i, int j) {
    return cache[i][j];
  }
  
  /**
   * Starts in the lower right corner of the cache
   * Runs Result.markPath() on each result along the path.
   * Highlights all the marked cells when 'Show path' is checked.
   * Uses StringBuilders to build the aligned strings in alignedX and alignedY
   * (uses Constants.GAP_CHAR for a gap in the strand).
   */
  private void traceback() {
    int xCoord = n, yCoord = m;
    StringBuilder xString = new StringBuilder(), yString = new StringBuilder();
    Result result = cache[xCoord][yCoord];
    while(result.getParent() != Direction.NONE) {
      result.markPath();
      if(result.getParent() == Direction.DIAGONAL) {
        xCoord--;
        yCoord--;
        xString.append(x.charAt(xCoord));
        yString.append(y.charAt(yCoord));
      }
      else if(result.getParent() == Direction.LEFT) {
        yCoord--;
        xString.append(Constants.GAP_CHAR);
        yString.append(y.charAt(yCoord));
      }
      else if(result.getParent() == Direction.UP) {
        xCoord--;
        xString.append(x.charAt(xCoord));
        yString.append(Constants.GAP_CHAR);
      }
      result = cache[xCoord][yCoord];
    }
    cache[0][0].markPath();
    alignedX = xString.reverse().toString();
    alignedY = yString.reverse().toString();
  }

  /**
   * Returns true iff these strands are seemingly aligned.
   */
  public boolean isAligned() {
    return alignedX != null && alignedY != null &&
        alignedX.length() == alignedY.length();
  }
  
  /**
   * Returns the score associated with the current alignment.
   */
  public int getScore() {
    if (isAligned())
      return judge.score(alignedX, alignedY);
    return 0;
  }

  /**
   * Returns a nice textual version of this alignment.
   */
  public String toString() {
    if (!isAligned())
      return "[X=" + x + ",Y=" + y + "]";
    final char GAP_SYM = '.', MATCH_SYM = '|', MISMATCH_SYM = ':';
    StringBuilder ans = new StringBuilder();
    ans.append(alignedX).append('\n');
    int n = alignedX.length();
    for (int i = 0; i < n; i++)
      if (alignedX.charAt(i) == Constants.GAP_CHAR || alignedY.charAt(i) == Constants.GAP_CHAR)
        ans.append(GAP_SYM);
      else if (alignedX.charAt(i) == alignedY.charAt(i))
        ans.append(MATCH_SYM);
      else
        ans.append(MISMATCH_SYM);
    ans.append('\n').append(alignedY).append('\n').append("score = ").append(getScore());
    return ans.toString();
  }

  /**
   * Returns a DNA strand of length n with randomly selected nucleotides.
   */
  private static String randomDNA(int n) {
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < n; i++)
      sb.append("ACGT".charAt(gen.nextInt(4)));
    return sb.toString();
  }

}
