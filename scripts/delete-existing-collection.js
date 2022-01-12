use fruits
print("Collections List before deleting - " + db.getCollectionNames())
print("Number of collections before deleting- " + db.demo.fruit.count())
print("Dropping the fruit collection - " + db.demo.fruit.deleteMany({}))
print("Number of collections after deleting - " + db.demo.fruit.count())
print("Collections List after deleting - " + db.getCollectionNames())