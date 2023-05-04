package io.github.yunanjeong.custom;
import io.confluent.connect.storage.partitioner.TimeBasedPartitioner;

public class TopiclessTimeBasedPartitioner<T> extends TimeBasedPartitioner<T> {
    @Override
    public String generatePartitionedPath(String topic, String encodedPartition) {
        return encodedPartition;
    }
}
