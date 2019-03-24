package bae.baesso.banco;

import static org.bson.codecs.configuration.CodecRegistries.fromProviders;

import javax.enterprise.context.ApplicationScoped;

import org.bson.codecs.BsonValueCodecProvider;
import org.bson.codecs.DocumentCodecProvider;
import org.bson.codecs.ValueCodecProvider;
import org.bson.codecs.configuration.CodecRegistry;
import org.bson.codecs.pojo.PojoCodecProvider;

import com.mongodb.MongoClientSettings;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

@ApplicationScoped
public class MongoConnection {

	private static MongoClient mongoClient;
	private static MongoDatabase mongoDatabase;

	static {
		CodecRegistry pojoCodecRegistry = fromProviders(new DocumentCodecProvider(), new BsonValueCodecProvider(),
				new ValueCodecProvider(), PojoCodecProvider.builder().automatic(true).build());

		MongoClientSettings settings = MongoClientSettings.builder().codecRegistry(pojoCodecRegistry).build();
		mongoClient = MongoClients.create(settings);

		mongoDatabase = mongoClient.getDatabase("trabalhoMongo");

	}

	public static MongoDatabase getDatabase() {
		return mongoDatabase;
	}
}
