import { Link } from "react-router-dom";

const Header = () => {
    return (
        <div className="flex justify-between items-center py-4 px-10 border-b border-gray-800">
            {/* Logo & Title */}
            <div className="flex items-center gap-5 cursor-pointer">
                <Link to="">
                    <img src="https://opensea.io/static/images/logos/opensea-logo.svg" alt="" className="h-10" />
                </Link>
                <h1 className="text-2xl text-white">DStake</h1>
            </div>

            {/* Search Bar */}
            <input
                type="text"
                placeholder="Search"
                className="text-white bg-gray-700 px-10 py-2 w-92 rounded-xl outline-none"
            />

            {/* Login Button */}
            <button className="bg-gray-800 py-2 px-6 rounded-xl text-white text-xl hover:bg-gray-900 transition duration-400">
                Login
            </button>
        </div>
    );
};

export default Header;
