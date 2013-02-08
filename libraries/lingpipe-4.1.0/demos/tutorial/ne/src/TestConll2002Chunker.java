import java.io.File;

import com.aliasi.chunk.AbstractCharLmRescoringChunker;
import com.aliasi.chunk.BioTagChunkCodec;
import com.aliasi.chunk.ChunkerEvaluator;
import com.aliasi.chunk.Chunking;
import com.aliasi.chunk.TagChunkCodec;
import com.aliasi.chunk.TagChunkCodecAdapters;

import com.aliasi.corpus.ObjectHandler;

import com.aliasi.util.AbstractExternalizable;

public class TestConll2002Chunker {

    public static void main(String[] args) throws Exception {
        File chunkerFile = new File(args[0]);
        File testFile = new File(args[1]);

        System.out.println("Reading compiled model from file=" + chunkerFile);
        AbstractCharLmRescoringChunker<?,?,?> chunker 
            = (AbstractCharLmRescoringChunker<?,?,?>) 
            AbstractExternalizable.readObject(chunkerFile);
        chunker.setNumChunkingsRescored(512);

        System.out.println("Setting up Evaluator");
        // ObjectHandler<Chunking>
        ChunkerEvaluator evaluator = new ChunkerEvaluator(chunker);
        evaluator.setVerbose(true);

        evaluator.setMaxNBest(128);
        evaluator.setMaxNBestReport(8);
        evaluator.setMaxConfidenceChunks(8);

        System.out.println("Setting up Data Parser");
        // Parser<ObjectHandler<Tagging<String>>>
        Conll2002ChunkTagParser parser
            = new Conll2002ChunkTagParser();
        parser.setHandler(evaluator);

        System.out.println("Running Tests on file=" + testFile);
        parser.parse(testFile); // charset = default = ISO-8859-1

        System.out.println("Results");
        System.out.println(evaluator.toString());

    }

}
