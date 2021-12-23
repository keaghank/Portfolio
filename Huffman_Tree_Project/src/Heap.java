import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Comparator;

/**
 * The keys in the heap must be stored in an array.
 *
 * There may be duplicate keys in the heap.
 *
 * The constructor takes an argument that specifies how objects in the
 * heap are to be compared. This argument is a java.util.Comparator,
 * which has a compare() method that has the same signature and behavior
 * as the compareTo() method found in the Comparable interface.
 *
 * Here are some examples of a Comparator<String>:
 *    (s, t) -> s.compareTo(t);
 *    (s, t) -> t.length() - s.length();
 *    (s, t) -> t.toLowerCase().compareTo(s.toLowerCase());
 *    (s, t) -> s.length() <= 3 ? -1 : 1;
 */

public class Heap<E> implements PriorityQueue<E> {
    protected List<E> keys;
    private Comparator<E> comparator;

    /**
     *
     * @param comparator
     * Constructs a Heap based on the given comparator
     * Heap is represented by an ArrayList<E> keys
     */
    public Heap(Comparator<E> comparator) {
        this.keys = new ArrayList<E>();
        this.comparator = comparator;
    }

    /**
     * Returns the comparator on which the keys in this heap are prioritized.
     */
    public Comparator<E> comparator() {
        return comparator;
    }

    /**
     * @throws NoSuchElementException if the heap is empty.
     * @return the 0 index of keys
     * This will be the highest priority element
     */
    public E peek() {
        if(keys.isEmpty())
            throw new NoSuchElementException();
        return keys.get(0);
    }

    /**
     * @param key
     * Add the key into keys
     * siftUp on the last index
     */
    public void insert(E key) {
        keys.add(key);
        siftUp(size() - 1);
    }

    /**
     * @throws NoSuchElementException if the heap is empty.
     * @return the deleted element at the root
     */
    public E delete() {
        if(keys.isEmpty())
            throw new NoSuchElementException();
        E last = keys.get(size() - 1);
        E first = keys.remove(0);
        keys.add(0, last);
        keys.remove(size() - 1);
        siftDown(0);

        return first;
    }

    @Override
    public E remove(E key) {
        return null;
    }

    @Override
    public E poll() {
        return null;
    }

    /**
     * @param p
     * Restores the ordering property of the heap by shifting down
     * at index p
     * Called by delete()
     */
    public void siftDown(int p) {
        int leftChild = getLeft(p);
        int rightChild = getRight(p);
        if (leftChild < size()) {
            if(comparator.compare(keys.get(leftChild), keys.get(p)) < 0 &&
                    (rightChild >= size() || comparator.compare(keys.get(rightChild), keys.get(p)) >= 0)) {
                swap(leftChild, p);
                siftDown(leftChild);
            }
            else if(comparator.compare(keys.get(leftChild), keys.get(p)) >= 0 &&
                    (rightChild < size() && comparator.compare(keys.get(rightChild), keys.get(p)) < 0)) {
                swap(rightChild, p);
                siftDown(rightChild);
            }
            else if(rightChild < size()) {
                int maxChild = comparator.compare(keys.get(leftChild), keys.get(rightChild));
                if(maxChild <= 0 && comparator.compare(keys.get(leftChild), keys.get(p)) < 0) {
                    swap(leftChild, p);
                    siftDown(leftChild);
                }
                else if(maxChild > 0 && comparator.compare(keys.get(rightChild), keys.get(p)) < 0) {
                    swap(rightChild, p);
                    siftDown(rightChild);
                }
            }
        }
    }

    /**
     * @param q
     * Restores the ordering property by sifting the key at position q up
     * into the heap
     * Called by insert()
     */
    public void siftUp(int q) {
        int parent;
        if(q != 0) {
            parent = getParent(q);
            if(comparator.compare(keys.get(parent), keys.get(q)) >= 0) {
                swap(parent, q);
                siftUp(parent);
            }
        }
    }

    /**
     * @param i
     * @param j
     * Swaps the values in keys of i and j
     */
    public void swap(int i, int j) {
        E temp = keys.get(i);
        keys.set(i, keys.get(j));
        keys.set(j, temp);
    }

    /**
     * Returns the number of keys in this heap.
     */
    public int size() {
        return keys.size();
    }

    /**
     * Returns a textual representation of this heap.
     */
    public String toString() {
        return keys.toString();
    }

    /**
     * @param p
     * @return the left child at index p
     */
    public static int getLeft(int p) {
        return (p * 2) + 1;
    }

    /**
     * @param p
     * @return the right child at index p
     */
    public static int getRight(int p) {
        return (p * 2) + 2;
    }

    /**
     * @param p
     * @return the parent at index p
     */
    public static int getParent(int p) {
        return (p - 1) / 2;
    }
}

/**
 * This is the same ADT given in lecture except that it has been
 * made generic and the accessor method, comparator(), has been
 * added.
 *
 * Don't make any changes to this file.
 */

interface PriorityQueue<E> {

    /**
     * Inserts the given key into this priority queue.
     */
    void insert(E key);

    /**
     * Retrieves and removes the highest priority key in this queue, or
     * returns null if this queue is empty.
     */
    E delete();

    /**
     * Remove the given key
     */
    E remove(E key);

    /**
     * Retrieve, and remove, the head of this queue.
     */
    E poll();

    /**
     * Retrieves, but does not remove, the head of this queue.
     */
    E peek();

    /**
     * Returns the comparator used to organize this queue.
     */
    Comparator<E> comparator();

    /**
     * Returns the number of keys in this queue.
     */
    int size();

    /**
     * Returns true iff this queue is empty.
     */
    default boolean isEmpty() {
        return size() == 0;
    }
}
