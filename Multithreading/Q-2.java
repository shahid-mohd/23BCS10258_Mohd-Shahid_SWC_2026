// Question 2: Parallel Word Search with Coordinator Thread

class WordSearchTask extends Thread {
    private String[] words;
    private String target;
    private int start, end;
    private boolean found = false;

    public WordSearchTask(String[] words, String target, int start, int end) {
        this.words = words;
        this.target = target;
        this.start = start;
        this.end = end;
    }

    @Override
    public void run() {
        for (int i = start; i < end; i++) {
            if (words[i].equalsIgnoreCase(target)) {
                found = true;
                System.out.println(
                        Thread.currentThread().getName()
                                + " found \"" + target + "\" at index " + i
                );
                break;
            }
        }
    }

    public boolean isFound() {
        return found;
    }
}

public class ParallelWordSearch {
    public static void main(String[] args) {
        String[] words = {
                "Java", "Python", "C++", "JavaScript",
                "Ruby", "Go", "Kotlin", "Swift",
                "Rust", "PHP", "Scala", "Dart"
        };

        String target = "Swift";

        int mid = words.length / 2;

        WordSearchTask worker1 =
                new WordSearchTask(words, target, 0, mid);

        WordSearchTask worker2 =
                new WordSearchTask(words, target, mid, words.length);

        worker1.setName("Worker-1");
        worker2.setName("Worker-2");

        worker1.start();
        worker2.start();

        try {
            worker1.join();
            worker2.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        boolean found =
                worker1.isFound() || worker2.isFound();

        System.out.println("\nCoordinator Thread:");
        if (found) {
            System.out.println("Search completed. Word found!");
        } else {
            System.out.println("Search completed. Word not found.");
        }
    }
}
