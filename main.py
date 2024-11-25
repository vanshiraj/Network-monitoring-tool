from PyQt5.QtCore import QProcess, Qt
from PyQt5.QtWidgets import (
    QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, QWidget, QPushButton, 
    QTextEdit, QLabel, QStackedWidget, QScrollArea, QSizePolicy, QFrame, QMessageBox
)
from PyQt5.QtGui import QIcon, QFont
import sys

class NetworkMonitor(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("SniffBeacons - Network Monitoring Tools")
        self.setGeometry(100, 100, 1200, 800)
        self.showMaximized()
        self.initUI()

    def initUI(self):
        # Load external stylesheet (CSS)
        self.load_stylesheet()

        # Central widget setup with layouts
        central_widget = QWidget(self)
        main_layout = QVBoxLayout(central_widget)

        # Header
        header_label = QLabel("Network Monitoring Tools")
        header_label.setObjectName("header")
        header_label.setAlignment(Qt.AlignCenter)

        # Scrollable sidebar
        sidebar = QFrame()
        sidebar.setFixedWidth(250)
        sidebar_layout = QVBoxLayout(sidebar)
        sidebar_layout.setAlignment(Qt.AlignTop)

        # Define buttons with scripts as class attribute for access in run_script
        self.buttons_info = [
            ("IP Address Info", "ip_info.sh"),
            ("Network Interfaces", "network_interfaces.sh"),
            ("Active Connections", "active_connections.sh"),
            ("Network Statistics", "network_statistics.sh"),
            ("Bandwidth Usage", "bandwidth_usage.sh"),
            ("Ping Test", "ping_test.sh"),
            ("DNS Lookup", "dns_lookup.sh"),
            ("Traceroute Test", "traceroute.sh"),
            ("Port Scan", "port_scan.sh"),
            ("Capture Packets", "packet_capture.sh"),
            ("Bandwidth Monitor", "show_bandwidth.sh")
        ]

        # Sidebar Buttons
        for title, script in self.buttons_info:
            btn = QPushButton(title)
            btn.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Minimum)
            btn.clicked.connect(lambda _, s=script: self.run_script(s))
            sidebar_layout.addWidget(btn)

        # Add Stop button for stopping the process
        stop_button = QPushButton("Stop Task")
        stop_button.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Minimum)
        stop_button.clicked.connect(self.stop_process)
        sidebar_layout.addWidget(stop_button)

        # Add Clear button for clearing the output
        clear_button = QPushButton("Clear Output")
        clear_button.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Minimum)
        clear_button.clicked.connect(self.clear_output)
        sidebar_layout.addWidget(clear_button)

        # Stacked Widget (Main display area for each tool)
        self.main_display = QStackedWidget()
        self.main_display.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)

        # Initialize display areas for each feature
        for title, _ in self.buttons_info:
            text_display = QTextEdit()
            text_display.setReadOnly(True)
            text_display.setPlaceholderText(f"{title} Output...")
            self.main_display.addWidget(text_display)

        # Layout adjustment
        content_layout = QHBoxLayout()
        content_layout.addWidget(sidebar, 1)
        content_layout.addWidget(self.main_display, 4)
        main_layout.addWidget(header_label)
        main_layout.addLayout(content_layout)

        # Footer
        footer_label = QLabel("Powered by SniffBeacons")
        footer_label.setObjectName("footer")
        footer_label.setAlignment(Qt.AlignCenter)
        main_layout.addWidget(footer_label)

        self.setCentralWidget(central_widget)

        # QProcess for running scripts
        self.process = QProcess(self)
        self.process.readyReadStandardOutput.connect(self.handle_output)

    def load_stylesheet(self):
        """Load the external stylesheet (QSS file)"""
        with open("./ProjectFinal/style.qss", "r") as file:
            self.setStyleSheet(file.read())

    # Run the .sh script and show the output in the display area
    def run_script(self, script_name):
        self.update_output(f"Running {script_name}...")

        # Set the correct display for the tool
        index = next(i for i, btn in enumerate(self.buttons_info) if btn[1] == script_name)
        self.main_display.setCurrentIndex(index)

        # Start the script using QProcess
        script_path = f'./ProjectFinal/SCRIPT/{script_name}'  # Ensure the path is correct
        self.process.start('bash', [script_path])

    # Update output in the QTextEdit widget
    def handle_output(self):
        output = self.process.readAllStandardOutput().data().decode()
        self.update_output(output)

    # Update text in the currently selected output widget
    def update_output(self, text):
        current_display = self.main_display.currentWidget()
        if isinstance(current_display, QTextEdit):
            current_display.append(text)

    # Stop process if running
    def stop_process(self):
        if self.process and self.process.state() == QProcess.Running:
            self.process.terminate()
            self.update_output("Process stopped by user.")
            self.clear_screen()  # Clear the display when task is stopped

    # Clear the current output display
    def clear_screen(self):
        current_display = self.main_display.currentWidget()
        if isinstance(current_display, QTextEdit):
            current_display.clear()

        self.show_popup("Task Stopped", "The current task has been stopped successfully!")

    # Clear the output area
    def clear_output(self):
        current_display = self.main_display.currentWidget()
        if isinstance(current_display, QTextEdit):
            current_display.clear()

        self.show_popup("Output Cleared", "The output has been cleared successfully!")

    # Show a custom popup message
    def show_popup(self, title, message):
        msg = QMessageBox()
        msg.setIcon(QMessageBox.Information)
        msg.setWindowTitle(title)
        msg.setText(message)
        msg.setStandardButtons(QMessageBox.Ok)
        msg.setStyleSheet("""
            QMessageBox {
                background-color: black;
                font-size: 16px;
            }
            QMessageBox QPushButton {
                background-color: #1f7a8c;
                color: white;
                font-size: 14px;
                padding: 10px;
                border-radius: 5px;
            }
            QMessageBox QPushButton:hover {
                background-color: #145e73;
            }
        """)
        msg.exec_()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = NetworkMonitor()
    window.show()
    sys.exit(app.exec_())