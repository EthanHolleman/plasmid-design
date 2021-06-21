EXPECT_SAMPLES=100
RAND_SEQ_NAMES = ['RAND-SEQ:{i}' for i in EXPECT_SAMPLES]

rule plot_rlooper_rand_seq_distrabution:
    conda:
        '../envs/R.yml'
    input:
        ale=expand(
            'testing/rlooper_benchmarking/completed_runs/{rand_fasta}.{length}/{rand_fasta}.{length}_avgG.wig',
            rand_fasta=RAND_SEQ_NAMES, allow_missing=True
        ),
        bpprob=expand(
            'testing/rlooper_benchmarking/completed_runs/{rand_fasta}.{length}/{rand_fasta}.{length}_bpprob.wig',
            rand_fasta=RAND_SEQ_NAMES, allow_missing=True
        )
    output:
        plot='output/expectations/rlooper/rlooper_expect.{length}.png',
        expect='output/expectations/rlooper/rlooper_expect.{length}.tsv'
    script:'../scripts/plot_rlooper_expect.R'


rule plot_spot_rna_rand_seq:
    conda:
        '../envs/R.yml'
    input:
        expand('testing/RNA_sec_struct/bpRNA/tsv/{rand_fasta}.{length}.tsv',
        rand_fasta=RAND_SEQ_NAMES, length=UNIQUE_LENGTH
        )
    output:
        plot='output/expectations/SPOTRNA/spotRNA_expect.{length}.png',
        expect='output/expectations/SPOTRNA/spotRNA_expect.{length}.tsv'
    script:'../scripts/plot_rna_struct_expect.R'

