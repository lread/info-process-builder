import java.io.File;
import java.io.IOException;
import java.util.Arrays;

public class PBResolveTest {

    public static void pbTest(String program, String dir) {
        System.out.println("\nrunning: " + program + " dir: " + dir);

        ProcessBuilder pb = new ProcessBuilder(Arrays.asList(program));
        pb.redirectErrorStream(true);
        pb.redirectOutput(ProcessBuilder.Redirect.INHERIT);

        if (dir != null) {
            pb.directory(new File(dir));
        }

        try {
            Process process = pb.start();
            process.waitFor();
        } catch (IOException | InterruptedException e) {
            System.out.println("*error* " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        System.out.println("cwd: " + System.getProperty("user.dir"));
        System.out.println("args: " + Arrays.toString(args));

        if (args.length < 1) {
            System.out.println("Usage: java PBResolveTest <program> [dir]");
            return;
        }

        String program = args[0];
        String dir = args.length > 1 ? args[1] : null;

        pbTest(program, dir);
    }
}
