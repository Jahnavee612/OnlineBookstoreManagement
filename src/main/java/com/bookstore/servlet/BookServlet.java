package com.bookstore.servlet;

import com.bookstore.dao.BookDAO;
import com.bookstore.model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/books")
public class BookServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        String action = request.getParameter("action");
        BookDAO bookDAO = new BookDAO();

        if (action == null) action = "list";

        switch (action) {

            case "search":
                String keyword = request.getParameter("keyword");
                List<Book> searchResults = bookDAO.searchBooks(keyword);
                request.setAttribute("books", searchResults);
                request.setAttribute("keyword", keyword);
                request.getRequestDispatcher("/jsp/home.jsp")
                       .forward(request, response);
                break;

            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                bookDAO.deleteBook(deleteId);
                response.sendRedirect(request.getContextPath() + "/books?action=manage");
                break;

            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                Book book = bookDAO.getBookById(editId);
                request.setAttribute("book", book);
                request.getRequestDispatcher("/admin/editBook.jsp")
                       .forward(request, response);
                break;

            case "manage":
                List<Book> allBooks = bookDAO.getAllBooks();
                request.setAttribute("books", allBooks);
                request.getRequestDispatcher("/admin/manageBooks.jsp")
                       .forward(request, response);
                break;

            default:
                List<Book> books = bookDAO.getAllBooks();
                request.setAttribute("books", books);
                request.getRequestDispatcher("/jsp/home.jsp")
                       .forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String action = request.getParameter("action");
        BookDAO bookDAO = new BookDAO();

        if ("add".equals(action)) {
            Book book = new Book();
            book.setTitle(request.getParameter("title"));
            book.setAuthor(request.getParameter("author"));
            book.setGenre(request.getParameter("genre"));
            book.setPrice(Double.parseDouble(request.getParameter("price")));
            book.setStock(Integer.parseInt(request.getParameter("stock")));
            book.setDescription(request.getParameter("description"));
            bookDAO.addBook(book);
            response.sendRedirect(request.getContextPath() + "/books?action=manage");

        } else if ("update".equals(action)) {
            Book book = new Book();
            book.setId(Integer.parseInt(request.getParameter("id")));
            book.setTitle(request.getParameter("title"));
            book.setAuthor(request.getParameter("author"));
            book.setGenre(request.getParameter("genre"));
            book.setPrice(Double.parseDouble(request.getParameter("price")));
            book.setStock(Integer.parseInt(request.getParameter("stock")));
            book.setDescription(request.getParameter("description"));
            bookDAO.updateBook(book);
            response.sendRedirect(request.getContextPath() + "/books?action=manage");
        }
    }
}