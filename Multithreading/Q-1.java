// Question 1: Countdown and Blast Off using Thread.join()

class CountdownThread extends Thread {
    @Override
    public void run() {
        try {
            for (int i = 10; i >= 1; i--) {
                System.out.println(i);
                Thread.sleep(1000); 
            }
        } catch (InterruptedException e) {
            System.out.println("Countdown interrupted");
        }
    }
}

public class CountdownAndBlastOff {
    public static void main(String[] args) {
        CountdownThread countdown = new CountdownThread();

        countdown.start();

        try {
            countdown.join();
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted");
        }

        System.out.println("🚀 Blast Off!");
    }
}
