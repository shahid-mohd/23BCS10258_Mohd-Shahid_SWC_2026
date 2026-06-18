import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;

public class Question5 {
    static AtomicBoolean[] seats = new AtomicBoolean[10];
    static AtomicInteger cnt = new AtomicInteger(0);

    static void book(String u) {
        for (int i = 0; i < 10; i++) {
            if (seats[i].compareAndSet(false, true)) {
                cnt.incrementAndGet();
                System.out.println(u + " got seat " + (i + 1));
                return;
            }
        }
        System.out.println(u + " no seat");
    }

    public static void main(String[] args) throws InterruptedException {
        for (int i = 0; i < 10; i++)
            seats[i] = new AtomicBoolean(false);

        Thread[] t = new Thread[100];
        for (int i = 0; i < 100; i++) {
            String n = "User" + (i + 1);
            t[i] = new Thread(() -> book(n));
            t[i].start();
        }
        for (Thread th : t) th.join();

        System.out.println("Booked: " + cnt.get() + "/10");
    }
}
