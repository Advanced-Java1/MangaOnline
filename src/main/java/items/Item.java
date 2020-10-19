package items;

public abstract class Item implements Comparable, getter {
    protected Integer id;
    protected String name;
    protected String author;
    protected String genre;
    protected Integer price;

    public Item(Integer id, String name, String author, String genre, Integer price) {
        this.id = id;
        this.name = name;
        this.author = author;
        this.genre = genre;
        this.price = price;
    }

    @Override
    public Integer getId() {
        return id;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public String getAuthor() {
        return author;
    }

    @Override
    public String getGenre() {
        return genre;
    }

    @Override
    public Integer getPrice() {
        return price;
    }

    @Override
    public int compareTo(Object o) {
        Item item = (Item) o;
        if (this.getPrice() > item.getPrice()) return 1;
        else if (this.getPrice() < item.getPrice()) return -1;
        return 0;
    }

    @Override
    public String toString() {
        return "Item{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", author='" + author + '\'' +
                ", genre='" + genre + '\'' +
                ", price=" + price +
                '}';
    }
}
