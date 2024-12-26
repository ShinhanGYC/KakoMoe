import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class KakoMoe {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        ArrayList<String> faces = new ArrayList<>();
        Collections.addAll(faces, "후쿠야마 마사하루", "키무라 타쿠야", "오노 사토시", "오카다 준이치", "타카하시 잇세이", "무카이 오사무", "오구리 슌", "니노미야 카즈나리", "마츠다 류헤이", "마츠다 쇼타", 
                 "미즈시마 히로", "마츠야마 켄이치", "야마시타 토모히사", "마츠자카 토리", "사토 타케루", "야기라 유야");

        System.out.println("라운드를 설정하세요 (32강 / 16강): ");
        int round = scanner.nextInt();

        while (round != 16 && round != 32) {
       System.out.println("유효하지 않은 입력입니다. 32 또는 16을 선택하세요.");
     System.out.print("다시 입력해주세요: ");
        round = scanner.nextInt();

        System.out.println(round + "강을 선택하셨군요. 이상형 월드컵을 시작하겠습니다.");

        Collections.shuffle(faces);
        ArrayList<String> participants = new ArrayList<>(faces.subList(0, round));

        while (participants.size() > 1) {
            System.out.println("\n" + participants.size() + "강을 시작합니다.");
            ArrayList<String> nextRound = new ArrayList<>();

            for (int i = 0; i < participants.size(); i += 2) {
                int currentMatch = (i / 2) + 1;
                int totalMatches = participants.size() / 2;

                System.out.println("(" + currentMatch + "/" + totalMatches + ") 라운드를 진행합니다.");
                String participant1 = participants.get(i);
                String participant2 = participants.get(i + 1);

                System.out.println("1. " + participant1);
                System.out.println("2. " + participant2);
                System.out.print("승자: ");

                int choice = scanner.nextInt();
                while (choice != 1 && choice != 2) {
                    System.out.println("유효하지 않은 입력입니다. 1 또는 2를 선택하세요. ");
                    choice = scanner.nextInt();
                }

                if (choice == 1) {
                    nextRound.add(participant1);
                } else {
                    nextRound.add(participant2);
                }
                System.out.println((choice == 1 ? participant1 : participant2) + "를 선택하셨군요.");               
                if (participants.size() > 2) { 
                    System.out.println("다음 라운드를 진행하겠습니다.");
                }

            }

            participants = nextRound;
        }

        System.out.println("축하합니다. 당신의 최애는 " + participants.get(0) + " 입니다.");
        scanner.close();
    }
}