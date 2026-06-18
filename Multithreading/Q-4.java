// Question 4: Deadlock Demo with Knife and Cutting Board

import java.lang.Thread;

public class DeadlockDemo {

    public static void main(String[] args) {

        final Object knife = new Object();
        final Object cuttingBoard = new Object();

        Thread chef1 = new Thread(() -> {
            synchronized (knife) {
                System.out.println("Chef-1 picked up the Knife.");

                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }

                System.out.println("Chef-1 waiting for Cutting Board...");

                synchronized (cuttingBoard) {
                    System.out.println("Chef-1 is chopping vegetables.");
                }
            }
        });

        Thread chef2 = new Thread(() -> {
            synchronized (cuttingBoard) {
                System.out.println("Chef-2 picked up the Cutting Board.");

                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }

                System.out.println("Chef-2 waiting for Knife...");

                synchronized (knife) {
                    System.out.println("Chef-2 is chopping vegetables.");
                }
            }
        });

        chef1.start();
        chef2.start();
    }
}
