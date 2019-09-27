package com.fizzed.stork.launcher;

import org.apache.commons.io.IOUtils;
import org.junit.Assert;
import org.junit.Test;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class MergerTest {


    @Test
    public void mergingLauncherFilesWithJavaArgsRetainsBothArgumentSets() throws IOException {

        String javaArgsFromBaseFile = "-Dsome-common-argument=true";
        String javaArgsFromProdFile = "-Dsome-specifc-argument=false";

        List<File> launcherFilesWithJavaArgs = new ArrayList<>();
        launcherFilesWithJavaArgs.add(getEmbeddedFile("merge_base.yml"));
        launcherFilesWithJavaArgs.add(getEmbeddedFile("merge_prod.yml"));

        File outputFile = File.createTempFile("stork-test-file", "tmp");
        outputFile.deleteOnExit();

        Merger.merge(launcherFilesWithJavaArgs, outputFile);

        String mergedFileContents = Files.readAllLines(Paths.get(outputFile.getPath()), StandardCharsets.UTF_8)
                                         .stream()
                                         .collect(Collectors.joining(" "));


        Assert.assertEquals("Merged file contains java args from base file", true, mergedFileContents.contains(javaArgsFromBaseFile));
        Assert.assertEquals("Merged file contains java args from prod file", true, mergedFileContents.contains(javaArgsFromProdFile));

    }

    private File getEmbeddedFile(String filename) throws IOException {
        URL url = getClass().getClassLoader().getResource(filename);
        InputStream inputStream = url.openStream();
        File file = File.createTempFile("stork-test-file", "tmp");
        file.deleteOnExit();
        Files.copy(inputStream, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        IOUtils.closeQuietly(inputStream);
        return file;
    }
}
