"""An implementation of an encoder-decoder style neural network that jointly
learns a sensing matrix and the decompression black box. Implementation is
using Tensorflow, with the first test being on the MNIST dataset"""
import tensorflow as tf
import tensorflow.examples.tutorials.mnist as tfmnist

mnist = tfmnist.input_data.read_data_sets("/tmp/data", one_hot=True)

# tf graph input
x = tf.placeholder(tf.float32, [None, 784])
y = tf.placeholder(tf.float32, [None, 784])

# Sensing matrix definition
sensing_w = tf.Variable(tf.truncated_normal([784, 600], stddev=0.03), name='sensing_w')
sensing_b = tf.Variable(tf.truncated_normal([600], stddev=0.01), name='sensing_b')

# Weights matrix definition
retrieval_w = tf.Variable(tf.truncated_normal([600, 784], stddev=0.03), name='retrieval_w')
retrieval_b = tf.Variable(tf.truncated_normal([784], stddev=0.01), name='retrieval_b')

sensing_layer = tf.matmul(x, sensing_w) + sensing_b
y_ = tf.matmul(sensing_layer, retrieval_w) + retrieval_b

# Loss function as MSE loss
mse = tf.losses.mean_squared_error(y, y_)







if __name__ == '__main__':
    # Parameters
    learning_rate = 0.00001
    epochs = 100
    batch_size = 100
    display_step = 1
    
    # add an optimiser
    optimiser = tf.train.AdamOptimizer(learning_rate=learning_rate).minimize(mse)

    # define an accuracy assessment operation
    correct_prediction = tf.equal(tf.argmax(y, 1), tf.argmax(y_, 1))
    accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

    # setup the initialisation operator
    init_op = tf.global_variables_initializer()

    with tf.Session() as sess:

        writer = tf.summary.FileWriter('./graphs', sess.graph)
        # initialise the variables
        sess.run(init_op)
        total_batch = int(len(mnist.train.labels) / batch_size)
        for epoch in range(epochs):
            avg_cost = 0
            for i in range(total_batch):
                batch_x, batch_y = mnist.train.next_batch(batch_size=batch_size)
                _, c = sess.run([optimiser, mse], 
                                feed_dict={x: batch_x, y: batch_x})
                avg_cost += c / total_batch
            test_acc = sess.run(accuracy, feed_dict={x: mnist.test.images, y: mnist.test.images})
            print("Epoch:", (epoch + 1), "cost =", "{:.3f}".format(avg_cost), 
                  " test accuracy: {:.3f}".format(test_acc))

        print("\nTraining complete!")
        print(sess.run(accuracy, feed_dict={x: mnist.test.images, y: mnist.test.images}))