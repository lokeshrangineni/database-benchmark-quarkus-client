use fruits
print("Collections List before deleting - " + db.getCollectionNames())
print("Number of collections - " + db.demo.fruit.count())
print("Dropping the fruit collection - " + db.demo.fruit.drop())
print("Collections List after deleting - " + db.getCollectionNames())